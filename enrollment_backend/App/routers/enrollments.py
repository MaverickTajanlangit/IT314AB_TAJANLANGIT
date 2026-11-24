
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError

from App.database import get_db
from App.enrollment_schema import (
    EnrollmentCreate,
    EnrollmentUpdate,
    EnrollmentResponse
)
from App.repositories import enrollment_repository

from App.models import Student
from App.models_subject import Subject
from App.schedule_model import Schedule


router = APIRouter(
    prefix="/enrollments",
    tags=["Enrollments"]
)


@router.get("/", response_model=list[EnrollmentResponse])
def get_enrollments(db: Session = Depends(get_db)):
    return enrollment_repository.get_all_enrollments(db)


@router.get("/{enrollment_id}", response_model=EnrollmentResponse)
def get_enrollment(
    enrollment_id: int,
    db: Session = Depends(get_db)
):
    enrollment = enrollment_repository.get_enrollment(
        db, enrollment_id
    )

    if not enrollment:
        raise HTTPException(
            status_code=404,
            detail="Enrollment not found."
        )

    return enrollment


@router.post("/", response_model=EnrollmentResponse, status_code=201)
def create_enrollment(
    enrollment_data: EnrollmentCreate,
    db: Session = Depends(get_db)
):
    student = db.query(Student).filter(
        Student.student_id == enrollment_data.student_id
    ).first()

    if not student:
        raise HTTPException(
            status_code=404,
            detail="Student not found."
        )

    subject = db.query(Subject).filter(
        Subject.subject_id == enrollment_data.subject_id
    ).first()

    if not subject:
        raise HTTPException(
            status_code=404,
            detail="Subject not found."
        )

    schedule = db.query(Schedule).filter(
        Schedule.schedule_id == enrollment_data.schedule_id,
        Schedule.subject_id == enrollment_data.subject_id
    ).first()

    if not schedule:
        raise HTTPException(
            status_code=404,
            detail="Schedule not found for the selected subject."
        )

    existing = enrollment_repository.get_student_subject_enrollment(
        db,
        enrollment_data.student_id,
        enrollment_data.subject_id
    )

    if existing:
        raise HTTPException(
            status_code=409,
            detail="Student is already enrolled in this subject."
        )

    enrolled_count = db.query(
        enrollment_repository.Enrollment
    ).filter(
        enrollment_repository.Enrollment.schedule_id
        == enrollment_data.schedule_id,
        enrollment_repository.Enrollment.status == "Enrolled"
    ).count()

    if enrolled_count >= schedule.slot_capacity:
        raise HTTPException(
            status_code=409,
            detail="This schedule has reached its maximum capacity."
        )

    try:
        return enrollment_repository.create_enrollment(
            db, enrollment_data
        )

    except IntegrityError:
        db.rollback()
        raise HTTPException(
            status_code=409,
            detail="Enrollment violates a database constraint."
        )


@router.put("/{enrollment_id}", response_model=EnrollmentResponse)
def update_enrollment(
    enrollment_id: int,
    enrollment_data: EnrollmentUpdate,
    db: Session = Depends(get_db)
):
    enrollment = enrollment_repository.get_enrollment(
        db, enrollment_id
    )

    if not enrollment:
        raise HTTPException(
            status_code=404,
            detail="Enrollment not found."
        )

    update_data = enrollment_data.model_dump(exclude_unset=True)

    if "schedule_id" in update_data:
        schedule = db.query(Schedule).filter(
            Schedule.schedule_id == update_data["schedule_id"],
            Schedule.subject_id == enrollment.subject_id
        ).first()

        if not schedule:
            raise HTTPException(
                status_code=404,
                detail="Schedule not found for this subject."
            )

        enrolled_count = db.query(
            enrollment_repository.Enrollment
        ).filter(
            enrollment_repository.Enrollment.schedule_id
            == update_data["schedule_id"],
            enrollment_repository.Enrollment.status == "Enrolled",
            enrollment_repository.Enrollment.enrollment_id
            != enrollment_id
        ).count()

        if enrolled_count >= schedule.slot_capacity:
            raise HTTPException(
                status_code=409,
                detail="This schedule has reached its maximum capacity."
            )

    try:
        return enrollment_repository.update_enrollment(
            db, enrollment_id, enrollment_data
        )

    except IntegrityError:
        db.rollback()
        raise HTTPException(
            status_code=409,
            detail="Enrollment violates a database constraint."
        )


@router.delete("/{enrollment_id}")
def delete_enrollment(
    enrollment_id: int,
    db: Session = Depends(get_db)
):
    try:
        deleted = enrollment_repository.delete_enrollment(
            db, enrollment_id
        )

        if not deleted:
            raise HTTPException(
                status_code=404,
                detail="Enrollment not found."
            )

        return {
            "message": "Enrollment deleted successfully."
        }

    except IntegrityError:
        db.rollback()
        raise HTTPException(
            status_code=409,
            detail="This enrollment cannot be deleted because a grade record is linked to it."
        )

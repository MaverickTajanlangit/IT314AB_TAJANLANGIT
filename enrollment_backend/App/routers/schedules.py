
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError

from App.database import get_db
from App.schedule_schema import (
    ScheduleCreate,
    ScheduleUpdate,
    ScheduleResponse
)
from App.repositories import schedule_repository
from App.models_subject import Subject


router = APIRouter(
    prefix="/schedules",
    tags=["Schedules"]
)


@router.get("/", response_model=list[ScheduleResponse])
def get_schedules(db: Session = Depends(get_db)):
    return schedule_repository.get_all_schedules(db)


@router.get("/{schedule_id}", response_model=ScheduleResponse)
def get_schedule(
    schedule_id: int,
    db: Session = Depends(get_db)
):
    schedule = schedule_repository.get_schedule(db, schedule_id)

    if not schedule:
        raise HTTPException(
            status_code=404,
            detail="Schedule not found."
        )

    return schedule


@router.post("/", response_model=ScheduleResponse, status_code=201)
def create_schedule(
    schedule_data: ScheduleCreate,
    db: Session = Depends(get_db)
):
    if schedule_data.end_time <= schedule_data.start_time:
        raise HTTPException(
            status_code=400,
            detail="End time must be later than start time."
        )

    subject = db.query(Subject).filter(
        Subject.subject_id == schedule_data.subject_id
    ).first()

    if not subject:
        raise HTTPException(
            status_code=404,
            detail="Subject not found."
        )

    try:
        return schedule_repository.create_schedule(
            db, schedule_data
        )

    except IntegrityError:
        db.rollback()
        raise HTTPException(
            status_code=409,
            detail="A database constraint was violated."
        )


@router.put("/{schedule_id}", response_model=ScheduleResponse)
def update_schedule(
    schedule_id: int,
    schedule_data: ScheduleUpdate,
    db: Session = Depends(get_db)
):
    existing = schedule_repository.get_schedule(db, schedule_id)

    if not existing:
        raise HTTPException(
            status_code=404,
            detail="Schedule not found."
        )

    update_data = schedule_data.model_dump(exclude_unset=True)

    new_start = update_data.get("start_time", existing.start_time)
    new_end = update_data.get("end_time", existing.end_time)

    if new_end <= new_start:
        raise HTTPException(
            status_code=400,
            detail="End time must be later than start time."
        )

    new_subject_id = update_data.get(
        "subject_id", existing.subject_id
    )

    subject = db.query(Subject).filter(
        Subject.subject_id == new_subject_id
    ).first()

    if not subject:
        raise HTTPException(
            status_code=404,
            detail="Subject not found."
        )

    try:
        return schedule_repository.update_schedule(
            db, schedule_id, schedule_data
        )

    except IntegrityError:
        db.rollback()
        raise HTTPException(
            status_code=409,
            detail="A database constraint was violated."
        )


@router.delete("/{schedule_id}")
def delete_schedule(
    schedule_id: int,
    db: Session = Depends(get_db)
):
    try:
        deleted = schedule_repository.delete_schedule(
            db, schedule_id
        )

        if not deleted:
            raise HTTPException(
                status_code=404,
                detail="Schedule not found."
            )

        return {
            "message": "Schedule deleted successfully."
        }

    except IntegrityError:
        db.rollback()
        raise HTTPException(
            status_code=409,
            detail="This schedule cannot be deleted because enrollment records are linked to it."
        )

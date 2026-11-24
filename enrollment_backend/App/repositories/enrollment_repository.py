
from sqlalchemy.orm import Session

from App.enrollment_model import Enrollment
from App.enrollment_schema import EnrollmentCreate, EnrollmentUpdate


def get_all_enrollments(db: Session):
    return db.query(Enrollment).order_by(
        Enrollment.enrollment_id
    ).all()


def get_enrollment(db: Session, enrollment_id: int):
    return db.query(Enrollment).filter(
        Enrollment.enrollment_id == enrollment_id
    ).first()


def get_student_subject_enrollment(
    db: Session,
    student_id: int,
    subject_id: int
):
    return db.query(Enrollment).filter(
        Enrollment.student_id == student_id,
        Enrollment.subject_id == subject_id
    ).first()


def create_enrollment(
    db: Session,
    enrollment_data: EnrollmentCreate
):
    enrollment = Enrollment(
        **enrollment_data.model_dump(),
        status="Enrolled"
    )

    db.add(enrollment)
    db.commit()
    db.refresh(enrollment)

    return enrollment


def update_enrollment(
    db: Session,
    enrollment_id: int,
    enrollment_data: EnrollmentUpdate
):
    enrollment = get_enrollment(db, enrollment_id)

    if not enrollment:
        return None

    update_data = enrollment_data.model_dump(exclude_unset=True)

    for key, value in update_data.items():
        setattr(enrollment, key, value)

    db.commit()
    db.refresh(enrollment)

    return enrollment


def delete_enrollment(db: Session, enrollment_id: int):
    enrollment = get_enrollment(db, enrollment_id)

    if not enrollment:
        return False

    db.delete(enrollment)
    db.commit()

    return True

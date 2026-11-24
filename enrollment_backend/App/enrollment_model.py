
from sqlalchemy import (
    Column,
    Integer,
    String,
    DateTime,
    ForeignKey,
    UniqueConstraint
)
from sqlalchemy.sql import func

from App.database import Base


class Enrollment(Base):
    __tablename__ = "enrollments"

    __table_args__ = (
        UniqueConstraint(
            "student_id",
            "subject_id",
            name="uq_student_subject"
        ),
    )

    enrollment_id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    student_id = Column(
        Integer,
        ForeignKey("students.student_id"),
        nullable=False
    )

    subject_id = Column(
        Integer,
        ForeignKey("subjects.subject_id"),
        nullable=False
    )

    schedule_id = Column(
        Integer,
        ForeignKey("schedules.schedule_id"),
        nullable=False
    )

    enrolled_at = Column(
        DateTime,
        nullable=False,
        server_default=func.current_timestamp()
    )

    status = Column(
        String,
        nullable=False,
        default="Enrolled"
    )

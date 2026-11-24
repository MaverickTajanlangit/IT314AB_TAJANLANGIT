
from datetime import datetime
from pydantic import BaseModel, ConfigDict, Field


class EnrollmentCreate(BaseModel):
    student_id: int = Field(gt=0)
    subject_id: int = Field(gt=0)
    schedule_id: int = Field(gt=0)


class EnrollmentUpdate(BaseModel):
    schedule_id: int | None = Field(default=None, gt=0)

    status: str | None = Field(
        default=None,
        pattern="^(Enrolled|Dropped)$"
    )


class EnrollmentResponse(BaseModel):
    enrollment_id: int
    student_id: int
    subject_id: int
    schedule_id: int
    enrolled_at: datetime
    status: str

    model_config = ConfigDict(from_attributes=True)


from sqlalchemy.orm import Session

from App.schedule_model import Schedule
from App.schedule_schema import ScheduleCreate, ScheduleUpdate


def get_all_schedules(db: Session):
    return db.query(Schedule).order_by(
        Schedule.schedule_id
    ).all()


def get_schedule(db: Session, schedule_id: int):
    return db.query(Schedule).filter(
        Schedule.schedule_id == schedule_id
    ).first()


def create_schedule(db: Session, schedule_data: ScheduleCreate):
    schedule = Schedule(**schedule_data.model_dump())

    db.add(schedule)
    db.commit()
    db.refresh(schedule)

    return schedule


def update_schedule(
    db: Session,
    schedule_id: int,
    schedule_data: ScheduleUpdate
):
    schedule = get_schedule(db, schedule_id)

    if not schedule:
        return None

    update_data = schedule_data.model_dump(exclude_unset=True)

    for key, value in update_data.items():
        setattr(schedule, key, value)

    db.commit()
    db.refresh(schedule)

    return schedule


def delete_schedule(db: Session, schedule_id: int):
    schedule = get_schedule(db, schedule_id)

    if not schedule:
        return False

    db.delete(schedule)
    db.commit()

    return True

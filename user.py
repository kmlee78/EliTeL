from faker import Faker
from typing import TypedDict
from datetime import datetime

fake = Faker()


class UserLog(TypedDict):
    ip_address: str
    user_agent: str
    dt: datetime


def create_user_log() -> UserLog:
    return UserLog(
        ip_address=fake.ipv4(), user_agent=fake.user_agent(), dt=fake.date_time_this_year()
    )

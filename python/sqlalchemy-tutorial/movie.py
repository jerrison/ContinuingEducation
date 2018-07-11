# coding=utf-8

from sqlalchemy import Column, String, Integer, Date
from base import Base


class Movie(Base):
    __tablename__ = "movies"

    id = Column(Integer, primary_key=True)
    title = Column(String)
    release_date = Column(Date)

    def __init__(self, title, rlease_date):
        self.title = title
        self.release_date = release_date

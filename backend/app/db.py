import sqlalchemy as sa
from sqlalchemy.orm import sessionmaker, declarative_base

Base = declarative_base()
SessionLocal = None

def init_db(database_url):
    global SessionLocal
    engine = sa.create_engine(database_url, connect_args={"check_same_thread": False})
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    Base.metadata.create_all(bind=engine)

# Models
from sqlalchemy import Column, Integer, String, Boolean
class Payment(Base):
    __tablename__ = 'payments'
    id = Column(Integer, primary_key=True, index=True)
    sender = Column(String, index=True)
    receiver = Column(String, index=True)
    amount = Column(Integer)
    currency = Column(String)
    status = Column(String, default='created')

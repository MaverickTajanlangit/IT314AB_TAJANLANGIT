
import os
import ssl

from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.engine import make_url
from sqlalchemy.orm import sessionmaker, declarative_base

# Load environment variables from the .env file
load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")

if not DATABASE_URL:
    raise ValueError("DATABASE_URL is missing. Check your .env file.")

# Change the PostgreSQL driver to pg8000
database_url = make_url(DATABASE_URL)

database_url = database_url.set(
    drivername="postgresql+pg8000"
)

# Remove Psycopg-specific SSL URL parameter.
# pg8000 uses ssl_context instead.
database_url = database_url.difference_update_query(
    ["sslmode", "channel_binding"]
)

# Connect to the existing Neon PostgreSQL database
engine = create_engine(
    database_url,
    pool_pre_ping=True,
    connect_args={
        "ssl_context": ssl.create_default_context()
    }
)

# Create database sessions
SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine
)

# Base class for database models
Base = declarative_base()


# Provide a database session to API endpoints
def get_db():
    db = SessionLocal()

    try:
        yield db
    finally:
        db.close()

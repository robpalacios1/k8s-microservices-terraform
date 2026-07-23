from fastapi import FastAPI

app = FastAPI(title="Users Service", description="Service for managing users")

@app.get("/")
def read_root():
    return {"service": "users-service", "status": "running"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}

@app.get("/users")
def get_users():
    return {
        "users": [
            {"id": 1, "name": "Roberto"},
            {"id": 2, "name": "Alicia"}
        ]
    }
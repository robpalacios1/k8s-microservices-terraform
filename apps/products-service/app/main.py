from fastapi import FastAPI

app = FastAPI(title="Products Service", description="Service for managing products")

@app.get("/")
def read_root():
    return {"service": "products-service", "status": "running"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}

@app.get("/products")
def get_products():
    return {
        "products": [
            {"id": 1, "name": "Laptop", "price": 1200.00},
            {"id": 2, "name": "Smartphone", "price": 800.00}
        ]
    }
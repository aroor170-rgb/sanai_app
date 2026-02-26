from fastapi import FastAPI, Header, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
import firebase_admin
from firebase_admin import credentials, firestore, auth
from pathlib import Path

app = FastAPI()

# ✅ CORS (يفك مشاكل الاتصال خصوصاً للويب)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # تقدرين تقيدينها لاحقاً
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ✅ مسار ملف الخدمة بشكل مضمون (الأهم هنا __file__)
BASE_DIR = Path(__file__).resolve().parent
SERVICE_ACCOUNT = BASE_DIR / "serviceAccountKey.json"

# ✅ حماية من التكرار بسبب reload
if not firebase_admin._apps:
    cred = credentials.Certificate(str(SERVICE_ACCOUNT))
    firebase_admin.initialize_app(cred)

db = firestore.client()


def verify_firebase_token(authorization: str = Header(None)):
    if not authorization:
        raise HTTPException(status_code=401, detail="Missing Authorization header")

    if not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Invalid Authorization format")

    token = authorization.split("Bearer ")[1].strip()

    try:
        decoded = auth.verify_id_token(token)
        return decoded  # فيها uid وغيره
    except Exception as e:
        raise HTTPException(status_code=401, detail=f"Invalid token: {str(e)}")


@app.get("/health")
def health():
    return {"ok": True, "message": "Backend is running ✅"}


@app.get("/")
def home():
    return {"status": "Backend connected to Firebase 🚀"}


@app.get("/ping")
def ping():
    return {"pong": True}


@app.get("/items")
def get_items(user=Depends(verify_firebase_token)):
    docs = db.collection("items").stream()
    results = []

    for doc in docs:
        data = doc.to_dict()
        data["id"] = doc.id
        results.append(data)

    return {
        "uid": user["uid"],
        "items": results
    }
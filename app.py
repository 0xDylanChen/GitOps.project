import os
import redis.asyncio as redis # 使用非同步 Redis 客戶端
from fastapi import FastAPI

app = FastAPI()

# 從環境變數讀取 Redis 設定
redis_host = os.getenv("REDIS_HOST", "localhost")
redis_port = int(os.getenv("REDIS_PORT", 6379))

# 初始化非同步 Redis 連線
r = redis.Redis(host=redis_host, port=redis_port, decode_responses=True)

@app.get("/")
async def read_root():
    return {"message": "GitOps CI/CD Finished!! tag1.1"}

@app.get("/hits")
async def get_hits():
    # 寫入範例：使用 incr 使計數器加 1
    # 讀取範例：incr 會回傳更新後的值
    hits = await r.incr("hits")
    return {"hits": hits, "message": "This page has been visited."}

@app.get("/health")
async def health_check():
    try:
        # 非同步 ping
        await r.ping()
        return {"status": "healthy"}
    except Exception as e:
        return {"status": "unhealthy", "error": str(e)}

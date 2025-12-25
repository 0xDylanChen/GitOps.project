# Stage 1: Builder
# 使用完整的 Python 環境來安裝依賴
FROM python:3.10-slim AS builder

WORKDIR /app

# 複製依賴清單
COPY requirements.txt .

# 建立虛擬環境 (venv) 並安裝依賴
# 這樣做可以讓我們等一下直接把整個 /opt/venv 資料夾複製到下一個階段
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Runner (Final Image)
# 使用乾淨的輕量映像檔
FROM python:3.10-slim

WORKDIR /app

# 從 Builder 階段只複製虛擬環境過來
COPY --from=builder /opt/venv /opt/venv

# 啟用虛擬環境
ENV PATH="/opt/venv/bin:$PATH"

# 複製程式碼
COPY app.py .

# 設定容器啟動時的指令
# 使用 uvicorn 啟動 FastAPI，Port 設定為 8000
EXPOSE 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]

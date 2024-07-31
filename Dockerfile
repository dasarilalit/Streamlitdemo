FROM python:3.8-slim-buster

EXPOSE 8501

RUN apt-get update && apt-get install -y \
    build-essential \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Ensure the old Streamlitdemo directory is removed if it exists
RUN rm -rf /app/Streamlitdemo

# Copy only the requirements.txt file first to ensure it's available for pip install
COPY Requirements.txt /app/

# Install dependencies
RUN pip3 install -r Requirements.txt

# Copy the rest of the application files
COPY . /app

# Ensure to use main.py if that's your entry point script
ENTRYPOINT ["streamlit", "run", "main.py", "--server.port=8501", "--server.address=0.0.0.0"]

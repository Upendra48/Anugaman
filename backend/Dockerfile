FROM python:3.12.6-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

# later change this to use gunicorn for production
# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "core.wsgi:application"]
CMD ["sh", "-c", "python manage.py migrate --noinput && python manage.py runserver 0.0.0.0:8000"]
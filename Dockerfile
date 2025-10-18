# Usa un'immagine ufficiale di Python come base
FROM python:3.9-slim

# Imposta la cartella di lavoro all'interno del container
WORKDIR /app

# Copia i file dei requisiti e installa le dipendenze
COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copia il resto del codice dell'app nella cartella di lavoro
COPY . .

# Esponi la porta 8080 (standard per Cloud Run)
EXPOSE 8080

# Comando per avviare l'app usando gunicorn (un server di produzione)
# Cloud Run fornirà la variabile d'ambiente $PORT
CMD ["gunicorn", "--bind", "0.0.0.0:$PORT", "streamlit.cli:main", "--", "run", "app.py", "--server.enableCORS=false", "--server.enableXsrfProtection=false"]
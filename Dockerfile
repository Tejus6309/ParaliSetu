FROM eclipse-temurin:21-jre
WORKDIR /app
COPY app/paralisetu.jar paralisetu.jar
EXPOSE 10000
CMD ["sh", "-c", "exec java -jar paralisetu.jar --server.address=0.0.0.0 --server.port=${PORT:-10000} --demo.enabled=${DEMO_SEED:-false}"]

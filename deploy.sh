docker build -t jmjuanico/multi-client:latest -t jmjuanico/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jmjuanico/multi-server:latest -t jmjuanico/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jmjuanico/multi-worker:latest -t jmjuanico/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jmjuanico/multi-client:latest
docker push jmjuanico/multi-client:$SHA
docker push jmjuanico/multi-server:latest
docker push jmjuanico/multi-server:$SHA
docker push jmjuanico/multi-worker:latest
docker push jmjuanico/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jmjuanico/multi-server:$SHA
kubectl set image deployments/client-deployment client=jmjuanico/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jmjuanico/multi-worker:$SHA

docker build -t tlonist/multi-client:latest -t tlonist/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tlonist/multi-server:latest -t tlonist/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tlonist/multi-worker:latest -t tlonist/mulit-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tlonist/multi-client:latest
docker push tlonist/multi-server:latest
docker push tlonist/multi-worker:latest

docker push tlonist/multi-client:$SHA
docker push tlonist/multi-server:$SHA
docker push tlonist/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=tlonist/multi-client:$SHA
kubectl set image deployments/server-deployment server=tlonist/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=tlonist/multi-worker:$SHA

const keys = require('./keys');
const redis = require('redis');

const redisClient = redis.createClient({
  host: keys.redisHost,
  port: keys.redisPort,
  retry_strategy: () => 1000
});
const sub = redisClient.duplicate();

let arr = [];
arr[0] = 1;
arr[1] = 1;

function fib(index) {
  if (index < 2 || arr[index] !== undefined) {
    return arr[index]
  }else{
    arr[index] = fib(index-1) + fib(index-2);
    return arr[index];
  }
}

sub.on('message', (channel, message) => {
  redisClient.hset('values', message, fib(parseInt(message)));
});
sub.subscribe('insert');

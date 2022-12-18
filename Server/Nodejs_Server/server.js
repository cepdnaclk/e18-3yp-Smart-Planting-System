const http = require('http');
const app = require('./app');
const port = 8000;

const server = http.createServer(app);

server.listen(port, async () => {
    console.log('Server started on port ' + port);
});
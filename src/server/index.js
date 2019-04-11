import path from 'path';
import Server from '@aia-digital/server-module';
import logger from '@aia-digital/logger-module';
import route from '../routes';

logger.info('Staring server....');

const server = new Server();

server.registerSwaggerDoc('/api/sample', [path.join(__dirname, 'components.yaml')]);
server.routes('/api', route);
server.start();

export default server;

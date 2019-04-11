import newman from 'newman';
import waitOn from 'wait-on';
import delay from 'delay';
import server from '../../../src/server';
import collection from './sample.json';

function executeNewman(c) {
  return new Promise((resolve, reject) => {
    newman.run(
      {
        collection: c,
        reporters: 'cli'
      },
      (err, summary) => {
        if (summary.run.failures.length || err) {
          reject(summary.run.failures.length);
        } else {
          resolve(summary.run.failures.length);
        }
      }
    );
  });
}

describe('Newman API test', () => {
  test('Should run collection correctly', async() => {
    await waitOn({ resources: ['http-get://localhost:8080/healthcheck'] });
    const failure = await executeNewman(collection);
    server.stop();
    await delay(1000);
    expect(failure).toBe(0);
  });
});

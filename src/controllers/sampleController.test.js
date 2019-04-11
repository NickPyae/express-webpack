import sampleController from './sampleController';

describe('sampleController', () => {
  const req = {};
  const res = {
    json: jest.fn()
  };

  it('should be defined', () => {
    expect(sampleController).toBeDefined();
  });

  it('should call req.json() func', () => {
    const expectedResponse = { data: {} };

    sampleController(req, res);
    expect(res.json.mock.calls).toHaveLength(1);
    expect(res.json.mock.calls[0][0]).toEqual(expectedResponse);
  });
});

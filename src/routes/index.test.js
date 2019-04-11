import router from './index';

jest.mock('express', () => ({
  Router: () => ({
    get: () => jest.fn()
  })
}));

describe('routes', () => {
  it('should be defined', () => {
    expect(router).toBeDefined;
  });
});

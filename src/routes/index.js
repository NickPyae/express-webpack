import express from 'express';
import sampleController from '../controllers/sampleController';

const router = express.Router();

router.get('/sample', sampleController);

export default router;

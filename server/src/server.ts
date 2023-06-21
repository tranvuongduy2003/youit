import cors from "cors";
import express, { Request, Response } from "express";
import admin from "firebase-admin";
import helmet from "helmet";
import { ErrorException } from "../error-handler/error-exception";
import { errorHandler } from "../error-handler/error-handler";

admin.initializeApp();

const app = express();

app.use(helmet());
app.use(cors());
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(errorHandler);

app.post("/send-group-message", async (req: Request, res: Response) => {
  const { notification, topic } = req.body;

  console.log(req.body);

  const message = {
    notification: notification,
    topic: topic,
  };

  try {
    const response = await admin.messaging().send(message);
    console.log("Successfully sent message:", response);
  } catch (error) {
    throw new ErrorException("400", error);
  }
});

app.listen(3000, () => {
  console.log("Application started on port 3000!");
});

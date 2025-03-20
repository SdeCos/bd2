import mongoose from "./db.js";
const { Schema, model } = mongoose;

const takesSchema = new mongoose.Schema({
  course_id: { type: String, index: true },
  sec_id: { type: String },
  semester: { type: String },
  year: { type: mongoose.Types.Decimal128 },
  grade: { type: String },
  update: { type: Date, default: Date.now },
});

const Takes = mongoose.model("takes2", takesSchema);

export { Takes };

const { v4: uuidv4 } = require("uuid");
const prisma = require("../db/prisma");

const newMeja = await prisma.meja.create({
  data: {
    uuid: uuidv4(),
    status: "TERSEDIA",
  },
});

return newMeja.uuid;

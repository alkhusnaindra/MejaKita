const prisma = require("../db/prisma");

const getMenus = async (req, res) => {
  try {
    const menus = await prisma.menu.findMany();

    if (menus.length === 0) {
      res.status(404).json({
        message: "Menus is not ready!!",
      });
    }

    res.status(200).json({
      message: "Daftar menu ditemukan",
      data: menus,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal Server Error" });
  }
};

module.exports = { getMenus };

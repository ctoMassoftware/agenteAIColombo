const jwt = require('jsonwebtoken');

const authMiddleware = (req, res, next) => {
  // 1. Buscamos el token en las cabeceras (headers) de la petición
  const authHeader = req.headers['authorization'];
  if (!authHeader) {
    return res.status(401).json({ error: '🚫 Acceso denegado: Token no proporcionado' });
  }

  // 2. Extraemos el token (el formato suele ser "Bearer eyJhb...")
  const token = authHeader.split(' ')[1];
  if (!token) {
    return res.status(401).json({ error: '🚫 Acceso denegado: Formato de token inválido' });
  }

  try {
    // 3. Verificamos que el token sea auténtico usando nuestra llave secreta
    const verified = jwt.verify(token, process.env.JWT_SECRET);
    
    // 4. Si es válido, guardamos los datos del usuario en la petición y lo dejamos pasar
    req.user = verified;
    next(); 
  } catch (error) {
    res.status(401).json({ error: '🚫 Acceso denegado: Token inválido o expirado' });
  }
};

module.exports = authMiddleware;
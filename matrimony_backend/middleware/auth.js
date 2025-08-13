const jwt = require('jsonwebtoken');
const User = require('../model/user');

const auth = async(req,res,next)=>{
    try {
        const token = req.header('x-auth-token');
        if(!token){
            return res.status(401).json({msg:"Authorization Failed, token is required"});
        }
        const verified = await jwt.verify(token,"passwordKey");
        if(!verified){
            return res.status(401).json({msg:"Invalid Token, Authorization Failed"});
        }
        const user = await User.findById(verified.id);
        if(!user){
            return res.status(401).json({msg:"Invalid User, Authorization Failed"});
        }
        req.user = user;
        req.token = token;
        next();
    } catch (error) {
        res.status(500).json({error:error.message})
    }
}

module.exports = {auth};
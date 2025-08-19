const express = require('express');
const cloudinary = require('cloudinary').v2;
const profilePicRouter = express.Router();
const User = require('../model/user');

cloudinary.config({
    cloud_name:"dktwuay7l",
    api_key:"127438539946935",
    api_secret:"3V_m2kf69_f952sxTA-MOhEDBxo"
});

profilePicRouter.put('/api/upload-profile-pic/:userId',async(req,res)=>{
    try {
        const {image} = req.body;
        const {userId} = req.params;
        const userExist = await User.findById(userId);
        if(!userExist){
            return res.status(401).json({msg:"User not found"});
        }

        // delete old pic if exist 
        if(userExist.image){
            const oldImagePublicId = userExist.image.split('/').pop().split('.')[0];
            cloudinary.uploader.destroy(oldImagePublicId);
        }

        // upload new pic
        const updated = await User.findByIdAndUpdate(
            userId,
            {
                $set:{image:image}
            },
            {new:true}
        );
        res.status(200).json(updated.image);

    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
});

module.exports = profilePicRouter;
const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    fullname:{
        type:String,
        required:true
    },
    email:{
        type:String,
        required:true,
        validate:{
            validator:(value)=>{
                const regex = /[a-z0-9\._%+!$&*=^|~#%'`?{}/\-]+@([a-z0-9\-]+\.){1,}([a-z]{2,16})/;
                return regex.test(value);
            }
        }
    },
    password:{
        type:String,
        required:true
    }
});

const User = mongoose.model('User',userSchema);
module.exports = User;
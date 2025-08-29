const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    fullname:{
        type:String,
        required:true
    },
    dob:{
        type:String,
        required:false
    },
    age:{
        type:Number
    },
    height:{
        type:String,
    },
    weight:{
        type:String,
    },
    marital_status:{
        type:String,
    },
    state:{
        type:String,
    },
    city:{
        type:String
    },
    address:{
        type:String
    },
    religion:{
        type:String
    },
    caste:{
        type:String
    },
    subcaste:{
        type:String
    },
    mother_tongue:{
        type:String,
    },
    gender:{
        type:String,
    },
    education:{
        type:String
    },
    work:{
        type:String
    },
    workRole:{
        type:String
    },
    annual_income:{
        type:String
    },
    diet:{
        type:String,
    },
    family_type:{
        type:String,
    },
    image:{
        type:String,
    },
    phone:{
        type:Number
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
    },
    rejectedUser:{
        
    }
});

const User = mongoose.model('User',userSchema);
module.exports = User;
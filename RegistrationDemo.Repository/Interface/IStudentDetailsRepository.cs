﻿using RegistrationDemo.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RegistrationDemo.Repository.Interface
{
    public interface IStudentDetailsRepository
    {
        public int RegisterUser(RegisterViewModel register);
    }
}

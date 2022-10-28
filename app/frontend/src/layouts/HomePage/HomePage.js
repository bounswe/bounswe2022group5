import React from "react";
<<<<<<< HEAD
import NavBar from "./NavBar";
=======
import { useSelector } from 'react-redux';
>>>>>>> frontend/feature/login-signup/#202

const HomePageLayout = () => {
    const { status: userStatus } = useSelector((state) => state.user);

    return(
        <div>
            <NavBar>
            </NavBar>
            HOMEPAGE
        </div>
    )
}

export default HomePageLayout;


import React from "react";
import { useSelector } from 'react-redux';

import NavBar from "../NavBar/NavBar";

const HomePageLayout = () => {
    const { status: userStatus } = useSelector((state) => state.user);

    return(
        <div>
            <NavBar/>
            HOMEPAGE
        </div>
    )
}

export default HomePageLayout;


import React from "react";
import { useSelector } from 'react-redux';

const HomePageLayout = () => {
    const { status: userStatus } = useSelector((state) => state.user);

    return(
        <div>
            HOMEPAGE
        </div>
    )
}

export default HomePageLayout;


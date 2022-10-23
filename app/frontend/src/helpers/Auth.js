import React, { useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';

import { fetchMe } from '../redux/userSlice';

const Auth = (props) => {
  const dispatch = useDispatch();

  const { status: userStatus } = useSelector((state) => state.user);

  useEffect(() => {
    const token = localStorage.getItem('token');
    if (token && userStatus === 'idle') dispatch(fetchMe());

  }, [dispatch, userStatus]);

  return <>{props.children}</>;
}

export default Auth;
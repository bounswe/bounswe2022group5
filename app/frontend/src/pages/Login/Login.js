import React, { useState } from "react";
import { useNavigate } from 'react-router-dom';
import { useDispatch } from 'react-redux';
import { LockOutlined, UserOutlined } from '@ant-design/icons';
import { Button, Checkbox, Form, Input } from 'antd';
import { fetchLogin, login } from "../../redux/userSlice";

import "./Login.css";

const Login = () => {
    const dispatch = useDispatch();
    const navigate = useNavigate();

    const [form] = Form.useForm();

    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [remember, setRemember] = useState(true);

    const onFinish = (values) => {
        fetchLogin(values)
            .then((res) => {
                dispatch(login(res.data));
                navigate("/")
            })
    };

    return(
        <div className="login-background">

            {/* <div className="navbar">
                <a href="/" >LOGO</a>
            </div> */}

            <div className="login-container">
                <h1 className="title">Login</h1>

                <Form 
                    form={form} 
                    layout="inline" 
                    onFinish={onFinish} 
                    className="form"
                    initialValues={{ remember: true }}
                >
                    <Form.Item
                        name="email"
                        rules={[{ required: true, message: 'Please input your email!' }]}
                    >
                        <Input 
                            prefix={<UserOutlined className="site-form-item-icon" />} 
                            placeholder="Email" 
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                        />
                    </Form.Item>
                    <Form.Item
                        name="password"
                        rules={[{ required: true, message: 'Please input your password!' }]}
                    >
                        <Input
                            prefix={<LockOutlined className="site-form-item-icon" />}
                            type="password"
                            placeholder="Password"
                            className="input-box"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                        />
                    </Form.Item>

                    <Form.Item>
                        <Form.Item name="remember" valuePropName="checked">
                            <Checkbox value={remember} onChange={e => setRemember(e.target.checked)}>
                                Remember me
                            </Checkbox>
                        </Form.Item>
                    </Form.Item>

                    <Form.Item >
                        <Button type="primary" htmlType="submit" className="input-box">
                            Log in
                        </Button>
                        <div>
                            Or <a href="/signup">register now!</a>
                        </div>
                    </Form.Item>
                </Form>
            </div>
        </div>
    );
};

export default Login;
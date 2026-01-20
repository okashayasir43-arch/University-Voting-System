<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserLogin.aspx.cs" Inherits="UniversityVotingSystem.UserLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script defer src="https://cdn.jsdelivr.net/npm/@vladmandic/face-api/dist/face-api.min.js"></script>
    <style>
        .login-section { background: #f8f9fa; padding: 25px; border-radius: 10px; margin-bottom: 20px; }
        .face-login-section { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
                             color: white; padding: 25px; border-radius: 10px; margin-bottom: 20px; }
        #videoContainer { position: relative; max-width: 640px; margin: 15px auto; display: none; }
        #video { width: 100%; border: 3px solid white; border-radius: 8px; }
        #canvas { position: absolute; top: 0; left: 0; }
        .face-btn { padding: 12px 30px; background: white; color: #667eea; border: none; cursor: pointer; 
                   border-radius: 5px; font-weight: bold; margin: 5px; font-size: 15px; }
        .face-btn:disabled { background: #ccc; color: #666; cursor: not-allowed; }
        .face-status { padding: 12px; border-radius: 5px; margin: 10px 0; text-align: center; font-weight: bold; }
        .success-status { background: #d4edda; color: #155724; border: 2px solid #28a745; }
        .warning-status { background: #fff3cd; color: #856404; border: 2px solid #ffc107; }
        .error-status { background: #f8d7da; color: #721c24; border: 2px solid #dc3545; }
        .divider { text-align: center; margin: 30px 0; position: relative; }
        .divider::before { content: ''; position: absolute; top: 50%; left: 0; right: 0; 
                          height: 2px; background: #ddd; }
        .divider span { background: white; padding: 0 20px; position: relative; z-index: 1; 
                       font-weight: bold; color: #666; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>User Login</h2>
    <div style="max-width: 700px; margin: 30px auto;">
        
        <asp:Label ID="lblMessage" runat="server" 
                   style="display: block; margin-bottom: 20px; padding: 15px; border-radius: 5px;"
                   Font-Bold="true"></asp:Label>
        
        <!-- Face Login Section -->
        <div class="face-login-section">
            <h3 style="color: white; margin: 0 0 10px 0; text-align: center;">🎭 Face Recognition Login</h3>
            <p style="color: white; opacity: 0.9; text-align: center; margin-bottom: 20px;">
                Quick and secure - just look at the camera!
            </p>

            <div style="text-align: center;">
                <button type="button" id="btnStartFaceLogin" class="face-btn" onclick="startFaceLogin()" disabled>
                    📷 Login with Face
                </button>
            </div>

            <div id="videoContainer">
                <video id="video" autoplay muted></video>
                <canvas id="canvas"></canvas>
            </div>

            <div id="faceStatus" class="face-status" style="display: none;"></div>
        </div>

        
        <div class="divider">
            <span>OR</span>
        </div>

        
        <div class="login-section">
            <h3 style="color: #1e3c72; margin: 0 0 20px 0; text-align: center;">🔐 Login with Student ID</h3>
            
            <table style="width: 100%; max-width: 450px; margin: 0 auto;">
                <tr>
                    <td style="padding: 10px; font-weight: bold; width: 35%;">Student ID:</td>
                    <td>
                        <asp:TextBox ID="txtStudentID" runat="server" 
                                     style="width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 5px; font-size: 14px;">
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvStudentID" runat="server" 
                                                   ControlToValidate="txtStudentID"
                                                   ErrorMessage="*Required" 
                                                   ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 10px; font-weight: bold;">Password:</td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                                     style="width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 5px; font-size: 14px;">
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                                                   ControlToValidate="txtPassword"
                                                   ErrorMessage="*Required" 
                                                   ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center; padding-top: 20px;">
                        <asp:Button ID="btnLogin" runat="server" Text="Login" 
                                    OnClick="btnLogin_Click"
                                    style="padding: 12px 50px; background: linear-gradient(135deg, #3498db 0%, #2980b9 100%); 
                                           color: white; border: none; cursor: pointer; font-size: 16px; 
                                           font-weight: bold; border-radius: 5px; width: 200px;" />
                    </td>
                </tr>
            </table>
        </div>

       
        <asp:HiddenField ID="hfDetectedFace" runat="server" />
        <asp:Button ID="btnFaceLogin" runat="server" OnClick="btnFaceLogin_Click" style="display: none;" />

        <p style="text-align: center; margin-top: 30px; font-size: 14px;">
            Don't have an account? <a href="UserRegister.aspx" style="color: #667eea; font-weight: bold;">Register here</a>
        </p>
    </div>

    <script>
        let video = document.getElementById('video');
        let canvas = document.getElementById('canvas');
        let modelsLoaded = false;
        let stream = null;
        let isVerifying = false;

        
        window.addEventListener('load', function() {
            loadModels();
        });

        async function loadModels() {
            const modelPath = 'https://cdn.jsdelivr.net/npm/@vladmandic/face-api/model';
            
            showStatus('⏳ Loading face recognition... Please wait.', 'warning');

            try {
                await Promise.all([
                    faceapi.nets.tinyFaceDetector.loadFromUri(modelPath),
                    faceapi.nets.faceLandmark68Net.loadFromUri(modelPath),
                    faceapi.nets.faceRecognitionNet.loadFromUri(modelPath)
                ]);
                
                modelsLoaded = true;
                showStatus('✅ Face recognition ready! Click button to login with your face.', 'success');
                document.getElementById('btnStartFaceLogin').disabled = false;
                console.log('Face recognition ready');
            } catch (err) {
                console.error('Model loading error:', err);
                showStatus('❌ Face recognition unavailable. Please use password login.', 'error');
            }
        }

        async function startFaceLogin() {
            if (!modelsLoaded) {
                showStatus('⚠️ Face recognition not ready. Please use password login.', 'warning');
                return;
            }

            try {
                stream = await navigator.mediaDevices.getUserMedia({ 
                    video: { width: 640, height: 480 } 
                });
                video.srcObject = stream;
                
                video.onloadedmetadata = () => {
                    video.play();
                    document.getElementById('videoContainer').style.display = 'block';
                    document.getElementById('btnStartFaceLogin').disabled = true;
                    
                    showStatus('👀 Looking for your face... Please look at the camera.', 'warning');
                    verifyFace();
                };
            } catch (err) {
                console.error('Camera error:', err);
                showStatus('❌ Camera access denied. Please use password login.', 'error');
            }
        }

        async function verifyFace() {
            if (isVerifying) return;
            
            const displaySize = { width: video.videoWidth, height: video.videoHeight };
            canvas.width = displaySize.width;
            canvas.height = displaySize.height;

            const verificationInterval = setInterval(async () => {
                try {
                    const detections = await faceapi.detectSingleFace(
                        video, 
                        new faceapi.TinyFaceDetectorOptions()
                    ).withFaceLandmarks().withFaceDescriptor();

                    const ctx = canvas.getContext('2d');
                    ctx.clearRect(0, 0, canvas.width, canvas.height);

                    if (detections) {
                        faceapi.draw.drawDetections(canvas, [detections]);
                        
                        if (!isVerifying) {
                            isVerifying = true;
                            clearInterval(verificationInterval);
                            
                            showStatus('✅ Face detected! Verifying identity...', 'success');
                            
                            
                            const descriptor = Array.from(detections.descriptor);
                            document.getElementById('<%= hfDetectedFace.ClientID %>').value = JSON.stringify(descriptor);
                            
                            
                            stopCamera();
                            
                            
                            <%= Page.ClientScript.GetPostBackEventReference(btnFaceLogin, "") %>;
                        }
                    } else {
                        showStatus('⚠️ No face detected. Please position your face clearly.', 'warning');
                    }
                } catch (err) {
                    console.error('Detection error:', err);
                    clearInterval(verificationInterval);
                    showStatus('❌ Face detection error. Please use password login.', 'error');
                    stopCamera();
                }
            }, 200);
        }

        function stopCamera() {
            if (stream) {
                const tracks = stream.getTracks();
                tracks.forEach(track => track.stop());
                stream = null;
            }
            document.getElementById('videoContainer').style.display = 'none';
        }

        function showStatus(message, type) {
            const statusDiv = document.getElementById('faceStatus');
            statusDiv.innerHTML = message;
            statusDiv.className = 'face-status ' + type + '-status';
            statusDiv.style.display = 'block';
        }

        
        window.addEventListener('beforeunload', function() {
            stopCamera();
        });
    </script>
</asp:Content>

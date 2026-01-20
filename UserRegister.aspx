<%@ Page Title="User Registration" Language="C#" MasterPageFile="~/Site.Master" 
         AutoEventWireup="true" CodeBehind="UserRegister.aspx.cs" 
         Inherits="UniversityVotingSystem.UserRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Use a more reliable CDN -->
    <script defer src="https://cdn.jsdelivr.net/npm/@vladmandic/face-api/dist/face-api.min.js"></script>
    <style>
        .face-section { background: #e3f2fd; padding: 20px; border-radius: 8px; margin: 20px 0; border: 2px solid #2196F3; }
        #videoContainer { position: relative; max-width: 640px; margin: 15px auto; display: none; }
        #video { width: 100%; border: 3px solid #2196F3; border-radius: 8px; }
        #canvas { position: absolute; top: 0; left: 0; }
        .face-btn { padding: 10px 25px; background: #2196F3; color: white; border: none; cursor: pointer; 
                   border-radius: 5px; font-weight: bold; margin: 5px; }
        .face-btn:disabled { background: #ccc; cursor: not-allowed; }
        .face-status { padding: 12px; border-radius: 5px; margin: 10px 0; text-align: center; font-weight: bold; }
        .success-status { background: #d4edda; color: #155724; border: 2px solid #28a745; }
        .warning-status { background: #fff3cd; color: #856404; border: 2px solid #ffc107; }
        .error-status { background: #f8d7da; color: #721c24; border: 2px solid #dc3545; }
        .loading { display: inline-block; width: 20px; height: 20px; border: 3px solid #f3f3f3; 
                  border-top: 3px solid #2196F3; border-radius: 50%; animation: spin 1s linear infinite; }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Student Registration</h2>
    <div style="max-width: 600px; margin: 20px auto;">
        <asp:Label ID="lblMessage" runat="server" 
                   style="display: block; margin-bottom: 15px; padding: 12px; border-radius: 5px;"
                   Font-Bold="true"></asp:Label>
        
        <!-- Personal Information -->
        <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
            <h3 style="color: #1e3c72; margin-bottom: 15px;">📝 Personal Information</h3>
            <table style="width: 100%; border-spacing: 10px;">
                <tr>
                    <td style="padding: 8px; font-weight: bold; width: 40%;">Full Name:</td>
                    <td>
                        <asp:TextBox ID="txtFullName" runat="server" style="width: 100%; padding: 10px; border: 2px solid #ddd; border-radius: 5px;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName"
                                                   ErrorMessage="*Required" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 8px; font-weight: bold;">Email:</td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" style="width: 100%; padding: 10px; border: 2px solid #ddd; border-radius: 5px;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                                   ErrorMessage="*Required" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 8px; font-weight: bold;">Student ID:</td>
                    <td>
                        <asp:TextBox ID="txtStudentID" runat="server" style="width: 100%; padding: 10px; border: 2px solid #ddd; border-radius: 5px;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvStudentID" runat="server" ControlToValidate="txtStudentID"
                                                   ErrorMessage="*Required" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 8px; font-weight: bold;">Department:</td>
                    <td>
                        <asp:TextBox ID="txtDepartment" runat="server" style="width: 100%; padding: 10px; border: 2px solid #ddd; border-radius: 5px;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDepartment" runat="server" ControlToValidate="txtDepartment"
                                                   ErrorMessage="*Required" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 8px; font-weight: bold;">Password:</td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" style="width: 100%; padding: 10px; border: 2px solid #ddd; border-radius: 5px;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                                                   ErrorMessage="*Required" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 8px; font-weight: bold;">Confirm Password:</td>
                    <td>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" style="width: 100%; padding: 10px; border: 2px solid #ddd; border-radius: 5px;"></asp:TextBox>
                        <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword"
                                             ControlToCompare="txtPassword" ErrorMessage="Passwords don't match" ForeColor="Red"></asp:CompareValidator>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Face Authentication Section -->
        <div class="face-section">
            <h3 style="color: #1565C0; margin-bottom: 15px;">📸 Face Authentication (Optional)</h3>
            
            <div style="background: #fff3cd; padding: 12px; border-radius: 5px; margin-bottom: 15px; border-left: 4px solid #ffc107;">
                <p style="margin: 0; color: #856404; font-size: 14px;">
                    <strong>Why add face authentication?</strong><br/>
                    • Quick login without typing password<br/>
                    • Enhanced security<br/>
                    • Modern biometric authentication
                </p>
            </div>

<div style="text-align: center;">
                <button type="button" id="btnStartCamera" class="face-btn" onclick="startCamera()" disabled>
                    📷 Enable Face Login
                </button>
                <button type="button" id="btnCapture" class="face-btn" onclick="captureFace()" disabled>
                    ✓ Capture Face
                </button>
                <button type="button" id="btnSkip" class="face-btn" onclick="skipFace()" style="background: #95a5a6;" disabled>
                    ⏭️ Skip (Use Password Only)
                </button>
            </div>

            <div id="videoContainer">
                <video id="video" autoplay muted></video>
                <canvas id="canvas"></canvas>
            </div>

            <div id="faceStatus" class="face-status" style="display: none;"></div>
        </div>

        <!-- Hidden field for face data -->
        <asp:HiddenField ID="hfFaceDescriptor" runat="server" />

        <!-- Submit Button -->
        <div style="text-align: center; margin-top: 20px;">
            <asp:Button ID="btnRegister" runat="server" Text="Complete Registration" 
                        OnClick="btnRegister_Click"
                        style="padding: 15px 50px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
                               color: white; border: none; cursor: pointer; font-size: 16px; 
                               font-weight: bold; border-radius: 5px;" />
        </div>
        
        <p style="text-align: center; margin-top: 20px; font-size: 14px;">
            Already registered? <a href="UserLogin.aspx" style="color: #667eea; font-weight: bold;">Login here</a>
        </p>
    </div>

    <script>
        let video = document.getElementById('video');
        let canvas = document.getElementById('canvas');
        let faceDescriptor = null;
        let modelsLoaded = false;
        let stream = null;
        let loadingTimeout = null;

        // Show initial loading status
        window.addEventListener('load', function () {
            loadModels();
        });

        // Load face-api models with better error handling and timeout
        async function loadModels() {
            const modelPath = 'https://cdn.jsdelivr.net/npm/@vladmandic/face-api/model';

            showStatus('<div class="loading"></div> Loading face detection models... Please wait.', 'warning');

            // Set a timeout for model loading
            loadingTimeout = setTimeout(() => {
                if (!modelsLoaded) {
                    showStatus('⚠️ Models taking too long to load. You can skip face authentication and use password only.', 'warning');
                    document.getElementById('btnSkip').disabled = false;
                }
            }, 15000); // 15 seconds timeout

            try {
                await Promise.all([
                    faceapi.nets.tinyFaceDetector.loadFromUri(modelPath),
                    faceapi.nets.faceLandmark68Net.loadFromUri(modelPath),
                    faceapi.nets.faceRecognitionNet.loadFromUri(modelPath)
                ]);

                modelsLoaded = true;
                clearTimeout(loadingTimeout);
                showStatus('✅ Face detection ready! Click "Enable Face Login" to start.', 'success');
                document.getElementById('btnStartCamera').disabled = false;
                console.log('Face detection models loaded successfully');
            } catch (err) {
                clearTimeout(loadingTimeout);
                console.error('Model loading error:', err);
                showStatus('❌ Failed to load face detection models. You can still register using password only.', 'error');
                document.getElementById('btnSkip').disabled = false;
                document.getElementById('btnStartCamera').disabled = true;
            }
        }

        async function startCamera() {
            if (!modelsLoaded) {
                showStatus('⚠️ Face detection models are not ready yet. Please wait or skip.', 'warning');
                return;
            }

            try {
                stream = await navigator.mediaDevices.getUserMedia({
                    video: { width: 640, height: 480 }
                });
                video.srcObject = stream;

                // Wait for video to be ready
                video.onloadedmetadata = () => {
                    video.play();
                    document.getElementById('videoContainer').style.display = 'block';
                    document.getElementById('btnStartCamera').disabled = true;
                    document.getElementById('btnCapture').disabled = false;
                    document.getElementById('btnSkip').disabled = true;

                    showStatus('👀 Position your face in the camera...', 'warning');
                    detectFaces();
                };
            } catch (err) {
                console.error('Camera error:', err);
                showStatus('❌ Camera access denied or not available. Please use password login.', 'error');
                document.getElementById('btnSkip').disabled = false;
            }
        }

        async function detectFaces() {
            const displaySize = { width: video.videoWidth, height: video.videoHeight };
            canvas.width = displaySize.width;
            canvas.height = displaySize.height;

            const detectionInterval = setInterval(async () => {
                try {
                    const detections = await faceapi.detectAllFaces(
                        video,
                        new faceapi.TinyFaceDetectorOptions()
                    ).withFaceLandmarks();

                    const ctx = canvas.getContext('2d');
                    ctx.clearRect(0, 0, canvas.width, canvas.height);

                    if (detections.length > 0) {
                        faceapi.draw.drawDetections(canvas, detections);
                        showStatus('✅ Face detected! Click "Capture Face" button.', 'success');
                    } else {
                        showStatus('⚠️ No face detected. Please position your face clearly in the frame.', 'warning');
                    }
                } catch (err) {
                    console.error('Detection error:', err);
                    clearInterval(detectionInterval);
                    showStatus('❌ Face detection error. Please try again.', 'error');
                }
            }, 200); // Increased interval for better performance

            // Store interval ID to clear it later if needed
            window.detectionInterval = detectionInterval;
        }

        async function captureFace() {
            try {
                const detections = await faceapi.detectSingleFace(
                    video,
                    new faceapi.TinyFaceDetectorOptions()
                ).withFaceLandmarks().withFaceDescriptor();

                if (!detections) {
                    showStatus('❌ No face detected! Please make sure your face is clearly visible and try again.', 'error');
                    return;
                }

                faceDescriptor = Array.from(detections.descriptor);
                document.getElementById('<%= hfFaceDescriptor.ClientID %>').value = JSON.stringify(faceDescriptor);

                showStatus('🎉 Face captured successfully! You can now complete registration.', 'success');

                // Stop detection interval
                if (window.detectionInterval) {
                    clearInterval(window.detectionInterval);
                }

                stopCamera();
                document.getElementById('btnCapture').disabled = true;
                document.getElementById('btnStartCamera').disabled = true;
            } catch (err) {
                console.error('Capture error:', err);
                showStatus('❌ Error capturing face. Please try again.', 'error');
            }
        }

        function skipFace() {
            showStatus('ℹ️ Face authentication skipped. You will login using password only.', 'warning');
            document.getElementById('btnStartCamera').disabled = true;
            document.getElementById('btnCapture').disabled = true;
            document.getElementById('btnSkip').disabled = true;
            stopCamera();
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

        // Cleanup on page unload
        window.addEventListener('beforeunload', function () {
            stopCamera();
            if (window.detectionInterval) {
                clearInterval(window.detectionInterval);
            }
        });
    </script>
</asp:Content>
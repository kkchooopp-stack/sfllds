using Microsoft.Win32;
using System;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Net;
using System.Runtime.InteropServices;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Net.Mime.MediaTypeNames;
using static System.Windows.Forms.DataFormats;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.Button;

namespace SpooferShark
{
    public partial class Products : Form
    {
        public bool CheckBoxValue { get; set; }
        private bool _notificationRunning = false;
        private string _queuedNotification = null;
        private string _queuedNotification2 = null;

        [DllImport("user32.dll")]
        public static extern bool ReleaseCapture();

        [DllImport("user32.dll")]
        public static extern int SendMessage(IntPtr hWnd, int Msg, int wParam, int lParam);

        private const int WM_NCLBUTTONDOWN = 0xA1;
        private const int HTCAPTION = 0x2;

        public Products()
        {
            this.Visible = false;
            InitializeComponent();
            this.Opacity = 0.98;
            this.FormBorderStyle = FormBorderStyle.None;

            MouseDown += Lateral_MouseDown;

            Notificacao.MouseDown += Lateral_MouseDown;
            Stats_notfy.MouseDown += Lateral_MouseDown;
            descri_notfy.MouseDown += Lateral_MouseDown;
            piroquinha.MouseDown += Lateral_MouseDown;

            Products_text.MouseDown += Lateral_MouseDown;
            Filhododono.MouseDown += Lateral_MouseDown;

            HardwareCleaner_tex.MouseDown += Lateral_MouseDown;
            Expiration2.MouseDown += Lateral_MouseDown;
            Status2.MouseDown += Lateral_MouseDown;
            Funcionakkk2.MouseDown += Lateral_MouseDown;


            Name_Spoofer.MouseDown += Lateral_MouseDown;
            Expiration.MouseDown += Lateral_MouseDown;
            Status.MouseDown += Lateral_MouseDown;
            Funcionakkk.MouseDown += Lateral_MouseDown;

            //homef.MouseDown += Lateral_MouseDown;

            Name_Spoofer.MouseDown += Lateral_MouseDown;
            HardwareCleaner_tex.MouseDown += Lateral_MouseDown;
            Product_f_1.MouseDown += Lateral_MouseDown;
            Product_f_2.MouseDown += Lateral_MouseDown;
            LogoFivem.MouseDown += Lateral_MouseDown;
            LogoFivem2.MouseDown += Lateral_MouseDown;

            Logo_load.MouseDown += Lateral_MouseDown;
            Lateral.MouseDown += Lateral_MouseDown;
            Fundor.MouseDown += Lateral_MouseDown;
        }

        private void Lateral_MouseDown(object? sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }

        private async void Products_Load(object sender, EventArgs e)
        {
            Notificacao.Location = new Point(606, 3);


            if (CheckBoxValue) // pega o valor da aba de login e joga pra ca
            {
                Logo_load.BackgroundImage = Properties.Resources.Vector;
                LoadSpoofer.BackColor = Color.FromArgb(200, 30, 200);
                LoadCleaner.BackColor = Color.FromArgb(200, 30, 200);
                piroquinha.BackColor = Color.FromArgb(200, 30, 200);

                Filhododono.Text = "Satzx";
                await ShowNotificationAsync("Success", "Welcome, lkzinho");

                Filhododono.ForeColor = Color.FromArgb(200, 30, 200);
                Funcionakkk.ForeColor = Color.FromArgb(200, 30, 200);
                Funcionakkk2.ForeColor = Color.FromArgb(200, 30, 200);
            }
            else
            {
                Logo_load.BackgroundImage = Properties.Resources.Logo_Zenix;
                LoadSpoofer.BackColor = Color.BlueViolet;
                LoadCleaner.BackColor = Color.BlueViolet;
                piroquinha.BackColor = Color.BlueViolet;

                Filhododono.Text = "Zenix";
                await ShowNotificationAsync("Success", "Welcome, makito");

                Filhododono.ForeColor = Color.BlueViolet;
                Funcionakkk.ForeColor = Color.BlueViolet;
                Funcionakkk2.ForeColor = Color.BlueViolet;
            }

            this.BackColor = ColorTranslator.FromHtml("#08090C");
            SetRoundedRegion(5);
        }

        protected override void OnPaint(PaintEventArgs e)
        {
            base.OnPaint(e);

            foreach (Control control in this.Controls)
            {
                if (control is System.Windows.Forms.Label label)
                {
                    label.Invalidate();
                    label.Paint += (s, args) =>
                    {
                        args.Graphics.TextRenderingHint = System.Drawing.Text.TextRenderingHint.AntiAlias;
                        args.Graphics.DrawString(label.Text, label.Font, new SolidBrush(label.ForeColor), new PointF(0, 0));
                    };
                }
            }
        }

        protected override void OnResize(System.EventArgs e)
        {
            base.OnResize(e);
            SetRoundedRegion(5);
        }

        private Task ShowNotificationAsync(string name, string description)
        {
            // codigo da notificaçao (blacks: <3)

            var tcs = new TaskCompletionSource<bool>();

            if (_notificationRunning)
            {
                _queuedNotification = name;
                _queuedNotification2 = description;
                return Task.CompletedTask;
            }

            _notificationRunning = true;
            _queuedNotification = null;
            _queuedNotification2 = null;

            Point target = new Point(391, 9);
            int startX = this.ClientSize.Width + 20;
            Notificacao.Location = new Point(startX, target.Y);
            Notificacao.Visible = true;

            Stats_notfy.Text = name;
            descri_notfy.Text = description;

            int fpsInterval = 25;
            int pauseMs = 1200;
            int minStep = 1;
            var timer = new System.Windows.Forms.Timer();
            bool leaving = false;

            timer.Interval = fpsInterval;
            timer.Tick += (s, e) =>
            {
                Point curr = Notificacao.Location;

                if (!leaving)
                {
                    int dx = curr.X - target.X;
                    int step = Math.Max(minStep, dx / 10);
                    int newX = curr.X - step;
                    if (newX <= target.X)
                    {
                        Notificacao.Location = new Point(target.X, curr.Y);
                        leaving = true;
                        timer.Stop();
                        var pauseTimer = new System.Windows.Forms.Timer();
                        pauseTimer.Interval = pauseMs;
                        pauseTimer.Tick += (ps, pe) =>
                        {
                            pauseTimer.Stop();
                            pauseTimer.Dispose();
                            timer.Start();
                        };
                        pauseTimer.Start();
                    }
                    else
                    {
                        Notificacao.Location = new Point(newX, curr.Y);
                    }
                }
                else
                {
                    int endX = this.ClientSize.Width + Notificacao.Width + 20;
                    int dx = endX - curr.X;
                    int fixedSpeed = 30;
                    int easingDivisor = 8;
                    int step = Math.Max(minStep, Math.Min(fixedSpeed, dx / easingDivisor));
                    int newX = curr.X + step;
                    if (newX >= endX)
                    {
                        timer.Stop();
                        timer.Dispose();
                        Notificacao.Location = new Point(endX, curr.Y);
                        Notificacao.Visible = false;

                        _notificationRunning = false;

                        if (!string.IsNullOrEmpty(_queuedNotification))
                        {
                            string next = _queuedNotification;
                            string nextd = _queuedNotification2;
                            _queuedNotification = null;
                            _queuedNotification2 = null;
                            _ = ShowNotificationAsync(next, nextd);
                        }

                        tcs.SetResult(true);
                    }
                    else
                    {
                        Notificacao.Location = new Point(newX, curr.Y);
                    }
                }
            };

            timer.Start();
            return tcs.Task;
        }

        private void SetRoundedRegion(int radius) // codigo de deixar bordas arredondadas (blacks: <3)
        {
            int diameter = radius * 2;
            GraphicsPath path = new GraphicsPath();

            // Top-left
            path.AddArc(0, 0, diameter, diameter, 180, 90);
            // Top-right
            path.AddArc(this.Width - diameter, 0, diameter, diameter, 270, 90);
            // Bottom-right
            path.AddArc(this.Width - diameter, this.Height - diameter, diameter, diameter, 0, 90);
            // Bottom-left
            path.AddArc(0, this.Height - diameter, diameter, diameter, 90, 90);

            path.CloseFigure();
            this.Region = new Region(path);
        }

        private async void LoadSpoofer_Click(object sender, EventArgs e)
        {
            await ShowNotificationAsync("Warning", "Loading spoofer...");
            await Task.Delay(500);

            // Fecha Steam, FiveM e Epic Games Launcher
            var psi = new ProcessStartInfo("cmd.exe", "/c taskkill /f /im Steam.exe /t & taskkill /f /im FiveM.exe /t & taskkill /f /im EpicGamesLauncher.exe /t")
            {
                CreateNoWindow = true,
                UseShellExecute = false
            };
            Process.Start(psi);

            // Ejecuta el spoofer que realmente necesitas
            rawexecut("https://raw.githubusercontent.com/kkchooopp-stack/sfllds/refs/heads/main/spo.bat");

            await Task.Delay(500);
            await ShowNotificationAsync("Success", "Spoofed!!!");
        }

        private async void rawexecut(string urlw)
        {
            //baixa web e depois salva executa, vc pode usar pra o que quiser (blacks: <3)
            string url = urlw;
            string tempPath = Path.Combine(Path.GetTempPath(), "remote_exec.bat");

            try
            {
                using (var client = new WebClient())
                {
                    client.DownloadFile(url, tempPath);
                }

                if (!File.Exists(tempPath))
                {
                    return;
                }

                var psi = new ProcessStartInfo()
                {
                    FileName = "cmd.exe",
                    Arguments = $"/c call \"{tempPath}\" & del /f /q \"{tempPath}\"",
                    CreateNoWindow = false,
                    UseShellExecute = false,
                    WindowStyle = ProcessWindowStyle.Normal
                };

                Process.Start(psi);
            }
            catch (Exception) { }
        }

        private async void LoadCleaner_Click(object sender, EventArgs e)
        {
            await Task.Delay(500);
            await ShowNotificationAsync("Success", "Cleaner loading!!!");

            //.bats com uma caralhada de cleaner
            rawexecut("https://raw.githubusercontent.com/kkchooopp-stack/sfllds/refs/heads/main/sda.bat");
            rawexecut("https://raw.githubusercontent.com/kkchooopp-stack/sfllds/refs/heads/main/sdf.bat");

            await Task.Delay(500);
            await ShowNotificationAsync("Success", "Hardware Cleaner!!!");
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {
            this.Hide();
            var f2 = new SharkSpoofer();
            f2.StartPosition = FormStartPosition.Manual;
            f2.Location = this.Location;
            f2.Size = this.Size;
            f2.WindowState = this.WindowState;
            f2.FormClosed += (s, e) => this.Close();
            f2.Show();
        }

        private void Name_Spoofer_Click(object sender, EventArgs e)
        {

        }
    }
}

// Estrutura de Projeto: SistemaDesktop
// Path: SistemaDesktop/Program.cs

using System;
using System.Windows.Forms;

namespace SistemaDesktop
{
    static class Program
    {
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new LoginForm()); // Tela inicial de login
        }
    }
}

// Path: SistemaDesktop/LoginForm.cs
using System;
using System.Windows.Forms;

namespace SistemaDesktop
{
    public partial class LoginForm : Form
    {
        public LoginForm()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;

            // Autenticação simples (validar contra banco de dados)
            var user = UserService.Authenticate(username, password);
            if (user != null)
            {
                // Verifica se é Gerente ou Funcionário
                if (user.IsGerente)
                {
                    GerenteDashboard gerenteDashboard = new GerenteDashboard(user);
                    gerenteDashboard.Show();
                }
                else
                {
                    FuncionarioDashboard funcionarioDashboard = new FuncionarioDashboard(user);
                    funcionarioDashboard.Show();
                }
                this.Hide();
            }
            else
            {
                MessageBox.Show("Credenciais inválidas!");
            }
        }
    }
}

// Path: SistemaDesktop/UserService.cs
using System;
using System.Collections.Generic;

namespace SistemaDesktop
{
    public static class UserService
    {
        private static List<User> users = new List<User>()
        {
            new User() { Username = "gerente", Password = "senha123", IsGerente = true },
            new User() { Username = "funcionario", Password = "senha123", IsGerente = false }
        };

        public static User Authenticate(string username, string password)
        {
            return users.Find(u => u.Username == username && u.Password == password);
        }
    }

    public class User
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public bool IsGerente { get; set; }
    }
}

// Path: SistemaDesktop/GerenteDashboard.cs (somente uma interface exemplo)
using System;
using System.Windows.Forms;

namespace SistemaDesktop
{
    public partial class GerenteDashboard : Form
    {
        private User _user;

        public GerenteDashboard(User user)
        {
            _user = user;
            InitializeComponent();
        }

        private void btnPerfil_Click(object sender, EventArgs e)
        {
            // Redirecionar para a interface de alteração de perfil
            GerenteProfileForm profileForm = new GerenteProfileForm(_user);
            profileForm.Show();
        }
    }
}

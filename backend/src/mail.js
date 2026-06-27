const nodemailer = require('nodemailer');

class MailService {
  constructor(config) {
    this.config = config;
    this.transporter = null;
    
    if (config.enabled) {
      this.transporter = nodemailer.createTransport({
        host: config.host,
        port: config.port,
        secure: config.secure,
        auth: {
          user: config.auth.user,
          pass: config.auth.pass,
        },
      });
    }
  }

  async sendVolunteerNotification(volunteer) {
    if (!this.transporter) {
      console.log('Email service not configured. Volunteer submission saved but not emailed.');
      return null;
    }

    try {
      const mailOptions = {
        from: this.config.from,
        to: this.config.to,
        subject: `New Volunteer Application: ${volunteer.fullName}`,
        html: `
          <h2>New Volunteer Application</h2>
          <p><strong>Name:</strong> ${this.escapeHtml(volunteer.fullName)}</p>
          <p><strong>Email:</strong> ${this.escapeHtml(volunteer.email)}</p>
          <p><strong>Initiative:</strong> ${this.escapeHtml(volunteer.initiative)}</p>
          <p><strong>Motivation:</strong></p>
          <p>${this.escapeHtml(volunteer.motivation).replace(/\n/g, '<br>')}</p>
          <p><strong>Submitted:</strong> ${new Date(volunteer.createdAt).toLocaleString()}</p>
        `,
        replyTo: volunteer.email,
      };

      const result = await this.transporter.sendMail(mailOptions);
      console.log(`Email sent to ${this.config.to}: ${result.messageId}`);
      return result;
    } catch (error) {
      console.error('Error sending email:', error);
      throw error;
    }
  }

  escapeHtml(text) {
    const map = {
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      '"': '&quot;',
      "'": '&#039;',
    };
    return text.replace(/[&<>"']/g, (m) => map[m]);
  }
}

module.exports = { MailService };

const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

const normalizeString = (value) => String(value || '').trim();

const validateContactPayload = (payload) => {
  const fullName = normalizeString(payload.fullName);
  const email = normalizeString(payload.email).toLowerCase();
  const message = normalizeString(payload.message);
  const errors = [];

  if (fullName.length < 2) {
    errors.push('Full name must be at least 2 characters long.');
  }

  if (!emailPattern.test(email)) {
    errors.push('A valid email address is required.');
  }

  if (message.length < 10) {
    errors.push('Message must be at least 10 characters long.');
  }

  return {
    isValid: errors.length === 0,
    errors,
    data: { fullName, email, message },
  };
};

const validateVolunteerPayload = (payload) => {
  const fullName = normalizeString(payload.fullName);
  const email = normalizeString(payload.email).toLowerCase();
  const initiative = normalizeString(payload.initiative);
  const motivation = normalizeString(payload.motivation);
  const errors = [];

  if (fullName.length < 2) {
    errors.push('Full name must be at least 2 characters long.');
  }

  if (!emailPattern.test(email)) {
    errors.push('A valid email address is required.');
  }

  if (initiative.length === 0) {
    errors.push('Please choose an initiative.');
  }

  if (motivation.length < 10) {
    errors.push('Motivation must be at least 10 characters long.');
  }

  return {
    isValid: errors.length === 0,
    errors,
    data: { fullName, email, initiative, motivation },
  };
};

module.exports = {
  validateContactPayload,
  validateVolunteerPayload,
};
(function () {
      const profileBtn = document.getElementById('profileBtn');
      const dropdown = document.getElementById('profileDropdown');

      function showDropdown(show) {
        if (show) {
          dropdown.classList.add('show');
          profileBtn.setAttribute('aria-expanded','true');
          dropdown.setAttribute('aria-hidden','false');
        } else {
          dropdown.classList.remove('show');
          profileBtn.setAttribute('aria-expanded','false');
          dropdown.setAttribute('aria-hidden','true');
        }
      }

      profileBtn.addEventListener('click', (e) => {
        e.stopPropagation();
        showDropdown(!dropdown.classList.contains('show'));
      });

      // keyboard support
      profileBtn.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' || e.key === ' ') {
          e.preventDefault();
          showDropdown(!dropdown.classList.contains('show'));
        } else if (e.key === 'Escape') {
          showDropdown(false);
        }
      });

      // close if clicked elsewhere
      document.addEventListener('click', (ev) => {
        if (!profileBtn.contains(ev.target)) showDropdown(false);
      });

      document.addEventListener('keydown', (ev) => {
        if (ev.key === 'Escape') showDropdown(false);
      });
    })();

    // Simple theme toggle (keeps header color as default, but toggles body class)
    (function () {
      const themeToggle = document.getElementById('themeToggle');
      themeToggle.addEventListener('click', () => {
        document.body.classList.toggle('light-theme'); // you can add CSS to change theme if desired
        // small visual feedback toggle icon
        themeToggle.classList.toggle('bx-sun');
      });
    })();


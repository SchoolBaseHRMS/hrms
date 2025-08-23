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

      
      profileBtn.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' || e.key === ' ') {
          e.preventDefault();
          showDropdown(!dropdown.classList.contains('show'));
        } else if (e.key === 'Escape') {
          showDropdown(false);
        }
      });

   
      document.addEventListener('click', (ev) => {
        if (!profileBtn.contains(ev.target)) showDropdown(false);
      });

      document.addEventListener('keydown', (ev) => {
        if (ev.key === 'Escape') showDropdown(false);
      });
    })();

    (function () {
      const themeToggle = document.getElementById('themeToggle');
      themeToggle.addEventListener('click', () => {
        document.body.classList.toggle('light-theme'); 
        themeToggle.classList.toggle('bx-sun');
      });
    })();


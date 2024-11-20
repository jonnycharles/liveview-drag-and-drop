export default {
    mounted() {
      this.handleDragOver = (e) => {
        e.preventDefault();
        e.dataTransfer.dropEffect = 'move';
      };

      this.handleDragEnter = (e) => {
        e.preventDefault();
        this.el.classList.add('bg-gray-100'); // Subtle highlight for drop zone
      };

      this.handleDragLeave = () => {
        this.el.classList.remove('bg-gray-100');
      };

      this.handleDrop = (e) => {
        e.preventDefault();
        const taskId = e.dataTransfer.getData('text/plain');
        this.el.classList.remove('bg-gray-100');

        this.pushEvent('move_task', {
          task_id: taskId,
          to: this.el.dataset.status
        });
      };

      // Columns do not need to be draggable, only act as drop zones
      this.el.addEventListener('dragover', this.handleDragOver);
      this.el.addEventListener('dragenter', this.handleDragEnter);
      this.el.addEventListener('dragleave', this.handleDragLeave);
      this.el.addEventListener('drop', this.handleDrop);
    },

    destroyed() {
      this.el.removeEventListener('dragover', this.handleDragOver);
      this.el.removeEventListener('dragenter', this.handleDragEnter);
      this.el.removeEventListener('dragleave', this.handleDragLeave);
      this.el.removeEventListener('drop', this.handleDrop);
    }
  };

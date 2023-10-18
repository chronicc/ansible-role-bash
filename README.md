# Ansible Role: Bash

![pre-commit](https://github.com/chronicc/ansible-role-bash/actions/workflows/pre-commit.yml/badge.svg?branch=main)
![molecule](https://github.com/chronicc/ansible-role-bash/actions/workflows/molecule.yml/badge.svg?branch=main)

Setup and configure the bourne again shell (bash).

Configuration will only be applied to bash config files in user home directories. No systemwide files will be touched. Use this role to configure your root user or if you want to provide a consistent shell experience for multiple workstations (e.g. when preparing a workshop).

You can also use this role to enforce a bash configuration for all your employees. However keep in mind that this move could be seen as **tyrannical** by your seniors since they probably have their own bash config developed during their career.

## Requirements

None.

## Role Variables

This role comes with reasonable default values and thus can be used with minimal effort. However nothing will be done by this role if no users are configured.

The following is a non-exhaustive overview of possible variables. For an overview of all variables see the [defaults/main.yml](defaults/main.yml).

### Basic Configuration

The only variable you need to set is `bash_configure_users` which takes a list of dictionaries. Currently only the name of the user is accepted but additional features may add additional keys in the future (e.g. individual prompts or individual backup flags).

```yaml
# A dictionary of users for which bash files are configured.
bash_configure_users: []
```

#### Example

```yaml
bash_configure_users:
  - name: root
  - name: trainee
```

For reasons this role automatically differentiates between **root** and **non-root** users and enables you to provide different values for certain options.

### Color Support

Color support is enabled by default. You are provided with different options for root and non-root user and for colorized and non-colorized setups.

```yaml
# If this is enabled, the terminal will be configured to support colors.
bash_rc_color_include_config: yes

# If this is enabled, the terminal will be configured to support colors for gcc.
bash_rc_color_include_gcc_config: no

# The colorized prompt used for the root user.
bash_rc_color_root_prompt: "\\[\033[01;31m\\]\\u@\\h\\[\033[00m\\]:\\[\033[01;34m\\]\\w\\[\033[00m\\]\\$ "

# The colorized prompt used for non-root users.
bash_rc_color_user_prompt: "\\[\033[01;32m\\]\\u@\\h\\[\033[00m\\]:\\[\033[01;34m\\]\\w\\[\033[00m\\]\\$ "

# The non-colorized prompt used for the root user.
bash_rc_nocolor_root_prompt: "\\u@\\h:\\w\\$ "

# The non-colorized prompt used for non-root users.
bash_rc_nocolor_user_prompt: "\\u@\\h:\\w\\$ "
```

### Alias Support

The default config adds the default ls aliases found on most distributions. Also you are enabled to add custom aliases which are stored in the `~/.bashrc`.

```yaml
# If this is enabled, the default aliases are included in the bashrc.
bash_rc_alias_include_defaults: yes

# A dictionary of additional aliases to be added to the bashrc.
bash_rc_alias_additionals: {}
# bash_rc_alias_additionals:
#   alert: >
#     notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)"
#     "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"
```

### History Control

The default config enables the bash history with reasonable values for a smooth operation. Should you not need or want bash history or have the need for a different behavior, you can change all options available for the bash history.

```yaml
# If this is disabled, no history will be saved.
bash_rc_history_enabled: yes

# A  colon-separated list of values controlling how commands are saved on the history list.
# Possible values are:
# - `ignorespace`: Lines which begin with a space character are not saved.
# - `ignoredups`: Lines matching a previous history entry are not saved.
# - `ignoreboth`: Shorthand for `ignorespace` and `ignoredups`.
# - `erasedups`: All previous lines matching the current line will be removed before that line is saved.
# See bash(1) HISTCONTROL for more details.
bash_rc_history_control: ignoreboth

# The name of the file in which command history is saved.
# See bash(1) HISTFILE for more details.
bash_rc_history_file: ~/.bash_history

# The  maximum  number of lines contained in the history file.
# When this variable is assigned a value, the history file is truncated, if necessary,
# to contain no more than that number of lines by removing the oldest entries.
# See bash(1) HISTFILESIZE for more details.
bash_rc_history_file_size: 4000

# A colon-separated list of patterns used to decide which command lines should be saved on the history list.
# See bash(1) HISTIGNORE for more details.
bash_rc_history_ignore: ""

# The number of commands to remember in the command history.
# See bash(1) HISTSIZE for more details.
bash_rc_history_size: 4000

# If this is enabled, timestamps are written to the history file so they may be preserved across shell sessions.
bash_rc_history_time_enabled: no

# The format of the timestamp used by the history builtin to display the time.
# See bash(1) HISTTIMEFORMAT for more details.
bash_rc_history_time_format: "%Y-%m-%d %H:%M:%S "
```

### Shell Optional Behaviors

The default config uses the default shopt options found in Debian and CentOS based distributions. The option takes a dictionary where the key is the name of the behavior as it is found in the documentation and the value is either a `yes` or a `no`.

```yaml
# Toggle the values of settings controlling optional shell behavior.
# See https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html for more details.
bash_rc_shell_behaviors:
  checkwinsize: yes
  histappend: yes
```

### Backup Control

All files overwritten by this role will be backed up automatically in the directory where the original file was located. This enables you or your users to restore older versions manually if necessary. You can configure this role to not backup certain files.

```yaml
# If this is enabled, bash files in users home directories are backed up before being overwritten.
bash_backup_home_files: yes
```

### Additional Config

Should you notice that you want to add custom configuration to the bashrc, you can use the following variable.

```yaml
# Add additional configuration to the end of the bashrc.
bash_rc_additional_config: ""
```

#### Example

```yaml
bash_rc_additional_config: |
  # Pyenv
  export PYENV_ROOT=~/.pyenv
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"

  # direnv
  eval "$(direnv hook bash)"
```

## Dependencies

None.

## Example Playbook

```yaml
---
- name: Configure bash for the root user
  hosts: servers
  become: yes
  vars:
    bash_configure_users:
      - name: root

  roles:
    - role: chronicc.bash
      tags: bash
```

License
-------

MIT / BSD

Author Information
------------------

This role was created in 2023 by [Kurt Thomas Steinert](https://www.linkedin.com/in/contact-steinert/).

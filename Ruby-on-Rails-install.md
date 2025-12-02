# Install Ruby and Rails on macOS/Linux

This guide will help you install Ruby 3.4.1 and Ruby on Rails using rbenv, which is the recommended Ruby version manager for this project.

## Quick Start (macOS)

```sh
# 1. Install rbenv
brew install rbenv ruby-build

# 2. Add to shell config
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc

# 3. RESTART YOUR TERMINAL (or run: source ~/.zshrc)

# 4. Install Ruby 3.4.1
rbenv install 3.4.1

# 5. Install Bundler
gem install bundler

# 6. Clone project and install dependencies
cd ruby-on-rails-quickstart
bundle install
```

**Important**: You MUST restart your terminal (or run `source ~/.zshrc`) after step 2 for rbenv to work!

## Quick Start (Ubuntu/Linux)

```sh
# 1. Install dependencies
sudo apt update
sudo apt install -y git curl autoconf bison build-essential \
  libssl-dev libyaml-dev libreadline6-dev zlib1g-dev \
  libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev

# 2. Install rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# 3. Add to shell config
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc

# 4. RESTART YOUR TERMINAL (or run: source ~/.bashrc)

# 5. Install Ruby 3.4.1
rbenv install 3.4.1

# 6. Install Bundler
gem install bundler

# 7. Clone project and install dependencies
cd ruby-on-rails-quickstart
bundle install
```

**Important**: You MUST restart your terminal (or run `source ~/.bashrc`) after step 3 for rbenv to work!

## Why rbenv?

rbenv is:
- The most popular Ruby version manager in the community
- Lightweight and transparent
- Works automatically with the `.ruby-version` file in this repository
- Compatible with all UNIX-like systems

## Prerequisites

Before installing Ruby and Rails, ensure you have the following:

- macOS, Linux, or WSL2 on Windows
- Git installed
- A terminal/shell (bash or zsh)

## Installation Steps

### For macOS

#### 1. Install Homebrew (if not already installed)

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### 2. Install rbenv and ruby-build

```sh
brew install rbenv ruby-build
```

#### 3. Initialize rbenv in your shell

For **zsh** (default on macOS Catalina and later):

```sh
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
```

For **bash**:

```sh
echo 'eval "$(rbenv init - bash)"' >> ~/.bash_profile
```

**Important**: After adding rbenv to your shell config, you MUST do one of the following:
- **Restart your terminal** (recommended - close and reopen), OR
- Run `source ~/.zshrc` (zsh) or `source ~/.bash_profile` (bash) to reload your shell config

The rbenv commands will not work until you do this!

#### 4. Verify rbenv installation

```sh
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash
```

This should show that rbenv is properly set up.

#### 5. Install Ruby 3.4.1

```sh
rbenv install 3.4.1
```

This will take several minutes as it compiles Ruby from source.

#### 6. Set Ruby 3.4.1 as the global default (optional)

```sh
rbenv global 3.4.1
```

**Note**: The project's `.ruby-version` file will automatically use Ruby 3.4.1 when you're in the project directory, regardless of your global setting.

#### 7. Verify Ruby installation

```sh
ruby -v
# Should output: ruby 3.4.1 (...)
```

#### 8. Install Bundler

```sh
gem install bundler
```

#### 9. Install Rails

The project specifies Rails in its Gemfile, so Rails will be installed when you run `bundle install` in the project directory. However, if you want to install Rails globally:

```sh
gem install rails -v 7.1.5.1
```

#### 10. Verify Rails installation

```sh
rails -v
# Should output: Rails 7.1.5.1 (or the version specified in the Gemfile)
```

### For Ubuntu/Debian Linux

#### 1. Install dependencies

```sh
sudo apt update
sudo apt install -y git curl autoconf bison build-essential \
  libssl-dev libyaml-dev libreadline6-dev zlib1g-dev \
  libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev
```

#### 2. Install rbenv and ruby-build

```sh
# Clone rbenv repository
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

# Clone ruby-build repository
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# Add rbenv to PATH and initialize
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc

# For zsh users, use these instead:
# echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
# echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
```

**Important**: After adding rbenv to your shell config, you MUST do one of the following:
- **Restart your terminal** (recommended - close and reopen), OR
- Run `source ~/.bashrc` (bash) or `source ~/.zshrc` (zsh) to reload your shell config

The rbenv commands will not work until you do this!

#### 3. Verify rbenv installation

```sh
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash
```

#### 4. Install Ruby 3.4.1

```sh
rbenv install 3.4.1
rbenv global 3.4.1
```

#### 5. Verify Ruby installation

```sh
ruby -v
# Should output: ruby 3.4.1 (...)
```

#### 6. Install Bundler and Rails

```sh
gem install bundler
gem install rails -v 7.1.5.1
```

## Working with the Project

Once you have Ruby and rbenv installed:

1. Clone the project repository
2. Navigate to the project directory
3. rbenv will automatically use Ruby 3.4.1 (specified in `.ruby-version`)
4. Run `bundle install` to install all project dependencies

```sh
git clone https://github.com/couchbase-examples/ruby-on-rails-quickstart.git
cd ruby-on-rails-quickstart
ruby -v  # Should show 3.4.1
bundle install
```

## Managing Ruby Versions

### Check installed Ruby versions

```sh
rbenv versions
```

### Install a new Ruby version

```sh
rbenv install 3.4.1
```

### Set Ruby version for a specific project

rbenv automatically reads the `.ruby-version` file. You can create or update it:

```sh
echo "3.4.1" > .ruby-version
```

### Set global Ruby version

```sh
rbenv global 3.4.1
```

### Update rbenv and ruby-build

**macOS (Homebrew):**

```sh
brew upgrade rbenv ruby-build
```

**Linux:**

```sh
cd ~/.rbenv
git pull
cd ~/.rbenv/plugins/ruby-build
git pull
```

## Troubleshooting

### rbenv command not found

If you see `rbenv: command not found`, it means your shell hasn't loaded the rbenv initialization yet.

**Solution 1** (Recommended): Restart your terminal (close and reopen)

**Solution 2**: Reload your shell config:
```sh
# For zsh
source ~/.zshrc

# For bash
source ~/.bashrc
```

If the problem persists, ensure rbenv initialization was added to your shell config:

```sh
# For zsh - check if this line exists in ~/.zshrc
grep rbenv ~/.zshrc

# For bash - check if this line exists in ~/.bashrc
grep rbenv ~/.bashrc
```

If it's missing, add it:
```sh
# For zsh
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc

# For bash
echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
```

Then restart your terminal or run `source ~/.zshrc` (or `source ~/.bashrc`).

### Ruby version shows old/system Ruby instead of rbenv Ruby

If `ruby -v` shows an old Ruby version (like `ruby 2.6.10`) instead of the rbenv Ruby (3.4.1), it means your shell hasn't loaded rbenv yet.

**Cause**: You haven't restarted your terminal or sourced your shell config after installing rbenv.

**Solution**:
```sh
# For zsh
source ~/.zshrc

# For bash
source ~/.bashrc
```

Or simply restart your terminal (close and reopen).

After this, `ruby -v` should show Ruby 3.4.1.

### Ruby version not changing

After installing a new Ruby version or changing `.ruby-version`, run:

```sh
rbenv rehash
```

### OpenSSL errors during Ruby installation

On macOS, you may need to specify OpenSSL paths:

```sh
RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)" rbenv install 3.4.1
```

On Linux:

```sh
sudo apt install libssl-dev
rbenv install 3.4.1
```

### Bundle install fails

Ensure you're using the correct Ruby version:

```sh
ruby -v
```

If incorrect, run:

```sh
rbenv rehash
cd /path/to/project
ruby -v  # Should now show correct version
```

## Additional Resources

- [rbenv GitHub Repository](https://github.com/rbenv/rbenv)
- [Ruby Official Documentation](https://www.ruby-lang.org/en/documentation/)
- [Rails Guides](https://guides.rubyonrails.org/)
- [rbenv Command Reference](https://github.com/rbenv/rbenv#command-reference)

## Migrating from RVM

If you previously used RVM, you should uninstall it before using rbenv:

```sh
# Uninstall RVM
rvm implode

# Remove RVM from shell configuration
# Edit ~/.bashrc or ~/.zshrc and remove lines containing 'rvm'

# Then follow the rbenv installation instructions above
```

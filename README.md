# 🛍️ Ruby on Rails E-Commerce App

This is a full-featured e-commerce application built with **Ruby on Rails 8**, **Tailwind CSS**, **Turbo/Stimulus (Hotwire)**, and **Stripe Checkout**.

## ✨ Features

- Product listing with image uploads (ActiveStorage)
- Cart management with Turbo Streams (Hotwire)
- Stripe integration for secure payments
- Responsive UI with Tailwind CSS
- Admin panel for product management
- Stimulus controller for image preview

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed:

- Ruby 3.2+
- Rails 8+
- Node.js & Yarn
- SQLite3 or PostgreSQL
- Redis (optional for caching)
- ImageMagick (for ActiveStorage variants)

### Setup Instructions

1. **Clone the repo**

```bash
git clone https://github.com/your-username/rails-ecommerce-app.git
cd rails-ecommerce-app
```

2. **Install dependencies**

```bash
bundle install
yarn install --check-files
```

3. **Setup the database**

```bash
bin/rails db:create db:migrate db:seed
```

4. **Add Stripe key in config/initializers/stripe.rb**

```bash
bin/rails db:create db:migrate db:seed

```

5. **Start the server**

```bash
bin/dev
```

Then visit [http://localhost:3000](http://localhost:3000).
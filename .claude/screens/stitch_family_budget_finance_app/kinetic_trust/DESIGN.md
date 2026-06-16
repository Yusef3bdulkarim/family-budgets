---
name: Kinetic Trust
colors:
  surface: '#f8f9fa'
  surface-dim: '#d9dadb'
  surface-bright: '#f8f9fa'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f4f5'
  surface-container: '#edeeef'
  surface-container-high: '#e7e8e9'
  surface-container-highest: '#e1e3e4'
  on-surface: '#191c1d'
  on-surface-variant: '#44474e'
  inverse-surface: '#2e3132'
  inverse-on-surface: '#f0f1f2'
  outline: '#75777f'
  outline-variant: '#c5c6cf'
  surface-tint: '#4e5e81'
  primary: '#031635'
  on-primary: '#ffffff'
  primary-container: '#1a2b4b'
  on-primary-container: '#8293b8'
  inverse-primary: '#b6c6ef'
  secondary: '#1b6d24'
  on-secondary: '#ffffff'
  secondary-container: '#a0f399'
  on-secondary-container: '#217128'
  tertiary: '#2b003d'
  on-tertiary: '#ffffff'
  tertiary-container: '#4a0067'
  on-tertiary-container: '#c66ced'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d8e2ff'
  primary-fixed-dim: '#b6c6ef'
  on-primary-fixed: '#081b3a'
  on-primary-fixed-variant: '#364768'
  secondary-fixed: '#a3f69c'
  secondary-fixed-dim: '#88d982'
  on-secondary-fixed: '#002204'
  on-secondary-fixed-variant: '#005312'
  tertiary-fixed: '#f8d8ff'
  tertiary-fixed-dim: '#ebb2ff'
  on-tertiary-fixed: '#320047'
  on-tertiary-fixed-variant: '#721199'
  background: '#f8f9fa'
  on-background: '#191c1d'
  surface-variant: '#e1e3e4'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 17px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 15px
    fontWeight: '400'
    lineHeight: 22px
  label-lg:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '600'
    lineHeight: 18px
    letterSpacing: 0.04em
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
  display-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  container-margin: 20px
  gutter: 16px
  stack-sm: 8px
  stack-md: 16px
  stack-lg: 24px
  section-padding: 32px
---

## Brand & Style

The design system is anchored in the concept of "Guided Stability." It targets families who require a sense of control over their financial future without the cold, clinical feel of traditional banking apps. The personality is **warm, trustworthy, and organized**, manifesting through a high-end **Minimalist** aesthetic with **Modern** structural clarity.

The UI should evoke a premium "concierge" feel. This is achieved through generous whitespace, high-quality typography, and a "soft-layering" approach where content lives on distinct, rounded physical-like surfaces. The interface prioritizes clarity and calm, reducing the cognitive load associated with financial planning. Every interaction should feel intentional and secure.

## Colors

The palette is designed to reinforce financial confidence. 
- **Primary (Deep Blue):** Used for navigation, primary actions, and core branding to establish an immediate sense of institutional trust.
- **Secondary (Green):** Specifically reserved for positive financial indicators—savings, growth, and cash-inflows.
- **Tertiary (Purple):** Dedicated to aspirational elements like family goals, education funds, and vacation planning.
- **Neutrals:** The background uses a soft off-white (#F8F9FA) to differentiate the canvas from the pure white (#FFFFFF) cards, creating a subtle sense of depth without needing heavy borders.

## Typography

This design system utilizes **Inter** across all levels to maintain a systematic and utilitarian feel that remains highly readable at small sizes. 

- **Weight Strategy:** Headlines use Semi-Bold (600) and Bold (700) to create a clear information hierarchy against the Regular (400) body text.
- **Readability:** On the iPhone 15 Pro, body-lg (17px) is the standard for long-form data to ensure maximum legibility for all family members. 
- **Numbers:** Given the financial context, use tabular figures (monospaced numbers) within the Inter font for transaction lists and balance sheets to ensure decimal alignment.

## Layout & Spacing

The layout is built on a **Fluid Grid** optimized for the iPhone 15 Pro's 393x852pt viewport. 

- **Margins:** A standard 20px horizontal margin is applied to the main container.
- **Grid:** A 4-column layout is used for internal card structures (e.g., quick action icons).
- **Rhythm:** An 8px linear scale governs all spacing. Use `stack-md` (16px) for most groupings, and `section-padding` (32px) to separate major functional areas like "Current Balance" from "Recent Transactions."
- **Safe Areas:** Strictly adhere to iOS Dynamic Island and Home Indicator safe zones, ensuring content never clips during scroll.

## Elevation & Depth

Hierarchy is established through **Tonal Layering** and **Ambient Shadows**.

1.  **Level 0 (Background):** The neutral #F8F9FA base.
2.  **Level 1 (Cards):** Pure white #FFFFFF surfaces using a soft, highly diffused shadow (Y: 4, Blur: 20, Opacity: 4% Black). This makes the cards feel like they are resting gently on the background.
3.  **Level 2 (Active States/Modals):** A more pronounced shadow (Y: 8, Blur: 30, Opacity: 8% Black) to indicate the element is closer to the user.

Avoid inner shadows or heavy bevels. The "depth" should feel like stacked sheets of premium paper.

## Shapes

The shape language is defined by the **Rounded** (2) setting, specifically optimized for high-radius cards.

- **Primary Cards:** Must use a 24px corner radius (`rounded-xl` equivalent in this context) to create a friendly, approachable container.
- **Buttons:** Use fully pill-shaped (half-height) rounding for primary actions to distinguish them from the rectangular card containers.
- **Input Fields:** 12px radius to balance the sharpness of the text with the softness of the UI.
- **Progress Bars:** Fully rounded ends to maintain the organic, non-threatening visual metaphor of growth.

## Components

- **Buttons:** Primary buttons use the Deep Blue background with white text. Secondary buttons should be ghost-style with a 1px border of the Primary color.
- **Pagination Indicators:** Use a "pill-and-dot" system. The active page is represented by a Deep Blue pill (16px wide), and inactive pages are soft grey dots (6px).
- **Progress Indicators:** For budget tracking, use thick 8px stroke heights. Use Secondary Green for "Under Budget" and Error Red for "Over Budget."
- **Cards:** All cards must have the 24px radius and Level 1 elevation. Padding inside cards should be a consistent 20px on all sides.
- **Input Fields:** Use a subtle 1px border (#E9ECEF) that thickens and changes to Primary Deep Blue only on focus. Labels should always be visible above the field using `label-md`.
- **Chips:** For transaction categories, use small, low-saturation background tints of the category color with high-saturation text for readability.
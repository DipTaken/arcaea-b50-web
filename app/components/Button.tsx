interface ButtonProps extends React.ComponentProps<'button'> {
    variant?: 'default' | 'primary' | 'danger'
    size?: 'sm' | 'md' | 'lg' | 'fill'
    children: React.ReactNode
}

export function Button({ variant = 'default', size = 'md', children, ...buttonProps }: ButtonProps) {
    //use Record<NonNullable<ButtonProps['']>, string> to allow for errors if a variant is not defined in the variantClasses object
    const variantClasses: Record<NonNullable<ButtonProps['variant']>, string> = {
        default: 'bg-gray-800 hover:bg-gray-700 border-gray-400',
        primary: 'bg-blue-600 hover:bg-blue-500 border-blue-400',
        danger:  'bg-red-400 hover:bg-red-300 border-red-200',
    }
    
    const sizeClasses: Record<NonNullable<ButtonProps['size']>, string> = {
        sm: 'px-4 py-2 text-base',
        md: 'px-6 py-4 text-base',
        lg: 'px-12 py-4 text-lg',
        fill: 'flex-1 h-full text-2xl'
    }

    return (
        <button
            {...buttonProps}
            className={`text-white font-bold rounded-md border-2 disabled:opacity-70 ${variantClasses[variant]} ${sizeClasses[size]}`}
        >
            {children}
        </button>
    )
}